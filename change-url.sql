# -------------------------------------------
# Configuration
# -------------------------------------------
SET @old_url = 'http://example.com';
SET @new_url = 'http://example.dev';
SET @db_prefix = 'wp_';

# -------------------------------------------
# You shouldn't need to edit anything below
# -------------------------------------------

# Set up options table query
SET @options_query = CONCAT('UPDATE ', @db_prefix, 'options SET option_value = replace(option_value, ?, ?) WHERE option_name = "home" OR option_name = "siteurl"');

# Set up posts table queries
SET @posts_query_1 = CONCAT('UPDATE ', @db_prefix, 'posts SET guid = REPLACE (guid, ?, ?)');
SET @posts_query_2 = CONCAT('UPDATE ', @db_prefix, 'posts SET post_content = REPLACE (post_content, ?, ?)');

# Set up postmeta table query
SET @postmeta_query = CONCAT('UPDATE ', @db_prefix, 'postmeta SET meta_value = REPLACE (meta_value, ?, ?)');

# Prepare queries
PREPARE query_1 FROM @options_query;
PREPARE query_2 FROM @posts_query_1;
PREPARE query_3 FROM @posts_query_2;
PREPARE query_4 FROM @postmeta_query;

# Execute queries
EXECUTE query_1 USING @old_url, @new_url;
EXECUTE query_2 USING @old_url, @new_url;
EXECUTE query_3 USING @old_url, @new_url;
EXECUTE query_4 USING @old_url, @new_url;

# Deallocate prepared queries
DEALLOCATE PREPARE query_1;
DEALLOCATE PREPARE query_2;
DEALLOCATE PREPARE query_3;
DEALLOCATE PREPARE query_4;