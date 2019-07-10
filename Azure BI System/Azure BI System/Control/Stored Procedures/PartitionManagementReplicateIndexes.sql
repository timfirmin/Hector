CREATE PROCEDURE [Control].[PartitionManagementReplicateIndexes]
			(@PrimaryTableName varchar(50),
				@StageTableName varchar(100),
				@Debug int = 0)
AS

-- =============================================
-- Author:		Adatis Consulting Ltd 
-- Create date: 2013-07-11
-- Description:	Copies the indexes and compression settings
--			from one table to another. Component in the Partition
--			Management set of stored procs.
-- Testline: Exec [Control].[PartitionManagementReplicateIndexes] '[DW].[FactSample]', '[DW].[FactSampleTest]', 1
-- =============================================

BEGIN
	SET NOCOUNT ON;

	DECLARE @Function int = 1,
		@rows INT,
		@Idxobjects INT,
		@idxcounter int = 1,
		@counter INT = 1 ,
		@IndexName nvarchar(100),
		@IndexType nvarchar(25),
		@TableID int,
		@indexColumns NVARCHAR(max) = '',
		@includeColumns NVARCHAR(max) = '',
		@IncludeStatement NVARCHAR(max) = '',
		@CreateStatement NVARCHAR(max) = '',
		@indexPadded VARCHAR(50),
		@IndexUnique VARCHAR(50),
		@RowLockAllowed VARCHAR(50),
		@PageLockAllowed VARCHAR(50),
		@StatisticsRecompute VARCHAR(50),
		@IndexCompression VARCHAR(50),
		@ErrorMessagee VARCHAR(500)

SET @TableID = OBJECT_ID(@PrimaryTableName,'TABLE')

--Validation
		--Ensure source table exists
		IF(SELECT COUNT(*) from sys.tables t WHERE t.object_id = OBJECT_ID (@PrimaryTableName, N'U') ) = 0
		BEGIN
			SET @ErrorMessagee = 'The source table could not be found, make sure the table name is correct.'

			RAISERROR (@ErrorMessagee,16,1,'number',5)
			RETURN
		END

		--Ensure staging table exists
		IF(SELECT COUNT(*) from sys.tables t WHERE t.object_id = OBJECT_ID (@StageTableName, N'U') ) = 0
		BEGIN
			Set @ErrorMessagee = 'The staging table could not be found, make sure the table name is correct.'

			RAISERROR (@ErrorMessagee,16,1,'number',5)
			RETURN
		END

		--Ensure staging table has no indexes
		IF(SELECT COUNT(*) from sys.indexes i WHERE i.object_id = OBJECT_ID (@StageTableName, N'U')
													and i.index_id > 0) > 0
		BEGIN
			Set @ErrorMessagee = 'The staging table is already indexed. Remove all existing indexes before importing indexes from parent'

			RAISERROR (@ErrorMessagee,16,1,'number',5)
			RETURN
		END

IF  @Function = 1
BEGIN
	IF (SELECT max(index_id) FROM sys.indexes WHERE object_id = OBJECT_ID(@PrimaryTableName,'TABLE') ) > 0
	BEGIN
		--Indexes exist, loop through and collect details
		DECLARE @Indexes TABLE
			(IndexID int,
			 Idxrow int,
			 Clmrow int,
			 IndexType nvarchar(50),
			 IndexName sysname,
			 ColumnName nvarchar(50),
			 SortOrder char(3),
			 TableName sysname,
			 KeyOrdinal tinyint,
			 PrimaryKey bit,
			 IncFlg bit)

			--find index columns
			INSERT INTO @Indexes
			SELECT 
				i.index_id IndexID,
				DENSE_RANK() over (Partition By i.object_id Order by i.index_id) Idxrow,
				ROW_NUMBER() over (Partition By i.object_id, i.index_id, ic.is_included_column Order by ic.key_ordinal) Clmrow,
				i.type_desc,
				i.name as IndexName,
				'[' + c.name + '] ' ColumnName,
				CASE WHEN ic.is_descending_key = 0 THEN 'asc' ELSE 'desc' END SortOrder,
				t.name as tablename,
				ic.key_ordinal,
				i.is_primary_key,
				case when i.type = 6 then 0 else ic.is_included_column end IncFlg
			FROM sys.indexes i inner join 
				sys.index_columns ic ON i.object_id = ic.object_id 
										and i.index_id = ic.index_id inner join 
				sys.tables t ON t.object_id = i.object_id Inner join
				sys.columns c ON ic.object_id = c.object_id
								and ic.column_id  = c.column_id 
			WHERE i.object_id = OBJECT_ID (@PrimaryTableName, N'U')
				and i.index_id > 0
			ORDER BY i.object_id, ic.key_ordinal ASC

			--loop through the table and build list of the columns
			SELECT @Idxobjects = max(Idxrow) FROM @Indexes

			WHILE @idxcounter <= @Idxobjects
			BEGIN
				--reset counters
				SELECT @indexColumns = '',
						@Counter = 1,
						@rows = (select count(*) from @Indexes where Idxrow = @idxcounter and IncFlg = 0),
						@IndexName = (select top 1 IndexName from @Indexes where Idxrow = @idxcounter),
						@IndexType = (select top 1 IndexType from @Indexes where Idxrow = @idxcounter)

				WHILE @Counter <= @rows
	
				BEGIN
					SELECT 
						 @indexColumns = @indexColumns + ', ' + ltrim(rtrim(ColumnName)) +' '+ SortOrder FROM @Indexes
					WHERE Clmrow = @counter
							and Idxrow = @idxcounter
							and IncFlg = 0
					SET @counter += 1
				END

				SET @indexColumns = RIGHT(@indexColumns, LEN(@indexColumns) - 2)

				IF @IndexType = 'NONCLUSTERED' and (select count(*) from @Indexes where Idxrow = @idxcounter and IncFlg = 1) > 0
				BEGIN
					SELECT @counter = 1,
						@rows = (select count(*) from @Indexes where Idxrow = @idxcounter and IncFlg = 1)
					
					WHILE @counter <= @rows
	
					BEGIN
						SELECT 
							 @includeColumns = @includeColumns + ', ' + ltrim(rtrim(ColumnName)) FROM @Indexes
						WHERE Clmrow = @counter
								and Idxrow = @idxcounter
								and IncFlg = 1

						SET @counter += 1
					END

					SET @includeColumns = RIGHT(@includeColumns, LEN(@includeColumns) - 2)

					SET @IncludeStatement = 'INCLUDE ('+@includeColumns+') '
				END

				--Get other index properties
				IF (INDEXPROPERTY(@TableID, @IndexName, 'IsPadded') = 1)
				SET @indexPadded = 'PAD_INDEX = ON'
				ELSE
				SET @indexPadded = 'PAD_INDEX = OFF'


				IF (INDEXPROPERTY(@TableID, @IndexName, 'IsRowLockDisallowed') = 1)
				SET @RowLockAllowed = ', ALLOW_ROW_LOCKS = OFF'
				ELSE
				SET @RowLockAllowed = ', ALLOW_ROW_LOCKS = ON'


				IF (INDEXPROPERTY(@TableID, @IndexName, 'IsPageLockDisallowed') = 1)
				SET @PageLockAllowed = ', ALLOW_PAGE_LOCKS = OFF'
				ELSE
				SET @PageLockAllowed = ', ALLOW_PAGE_LOCKS = ON'


				-- Check if the index is unique
				IF (INDEXPROPERTY(@TableID, @IndexName, 'IsUnique') = 1)
				SET @IndexUnique = 'UNIQUE '
				ELSE 
				SET @IndexUnique = ''


				IF (INDEXPROPERTY(@TableID, @IndexName, 'IsStatistics') = 1)
				SET @StatisticsRecompute = ', STATISTICS_NORECOMPUTE = ON'
				ELSE 
				SET @StatisticsRecompute = ', STATISTICS_NORECOMPUTE = OFF'

				--Find index compression type

				SELECT top 1 @IndexCompression =
						CASE 
							WHEN data_compression_desc = 'NONE' THEN ', DATA_COMPRESSION = NONE '
							WHEN data_compression_desc = 'PAGE' THEN ', DATA_COMPRESSION = PAGE '
							WHEN data_compression_desc = 'ROW' THEN ', DATA_COMPRESSION = ROW '
							WHEN data_compression_desc = 'COLUMNSTORE' THEN ''
						END 
					 FROM sys.partitions PAR
				INNER Join sys.indexes IDX ON PAR.object_id = IDX.object_id AND PAR.index_id = IDX.index_id
				WHERE PAR.object_id = @TableID
					and IDX.name = @IndexName

				DECLARE @StrippedTableName varchar(100) = REPLACE(REPLACE(REPLACE(@StageTableName,'.',''),'[',''),']','')

				--build the create statement
				SET @CreateStatement = CASE WHEN @IndexType = 'NONCLUSTERED COLUMNSTORE'
				THEN 'CREATE ' + @IndexUnique + @IndexType +' INDEX [Indx_' + @StrippedTableName + cast(@idxcounter as varchar) + '] ON ' 
										+ @StageTableName + ' (' + REPLACE(REPLACE(@indexColumns,' asc',''),' desc','') + ') '
				ELSE 'CREATE ' + @IndexUnique + @IndexType +' INDEX [Indx_' + @StrippedTableName + cast(@idxcounter as varchar) + '] ON ' 
										+ @StageTableName + ' (' + @indexColumns + ') ' +@IncludeStatement+'WITH (' + @indexPadded + @RowLockAllowed + @PageLockAllowed
										+ @StatisticsRecompute + @IndexCompression + ')'
				END
				
				
				IF @Debug = 1
				BEGIN
					print @CreateStatement
				END
				ELSE
				BEGIN
					Exec(@CreateStatement)
				END

				SET @idxcounter += 1
				CONTINUE;
			END
	END

	IF EXISTS(SELECT null FROM sys.indexes WHERE object_id = OBJECT_ID(@PrimaryTableName,'TABLE') and index_id = 0)
	--Determine Compression
	set @IndexCompression = (select top 1 data_compression_desc from sys.partitions where object_id = OBJECT_ID(@PrimaryTableName,'TABLE'))

	IF @Debug = 1
	BEGIN
		print 'ALTER TABLE '+@StageTableName+' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = '+@IndexCompression+')'
	END
	ELSE
	BEGIN
		Exec('ALTER TABLE '+@StageTableName+' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = '+@IndexCompression+')')
	END
END

IF @Function = 2
	BEGIN
		IF @Debug = 1
		BEGIN
			print 'ALTER TABLE '+@StageTableName+' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = '+@IndexCompression+')'
		END
		ELSE
		BEGIN
			Exec('ALTER TABLE '+@StageTableName+' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = '+@IndexCompression+')')
		END
	END
END
