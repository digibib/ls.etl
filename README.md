Load of example-data (test-data for manual user-testing) into ls.ext

Koha needs the following entities:
- branch
- item type
- patron category
- patron
- bibliographic data

Process:
- Prepare or extract example data from source.
- If necessary transform example data. Use e.g. Catmandu importer
- Load (transformed) example data into Koha.
- Test that koha is in a legal state.

We utilize the import-functions in Koha to get the data into it. In general
there are three ways of doing this:
- by admin/user-interface, 
- by api,
- by database load.

We prefer loading by api.

Mapping of entities to import-function in Koha:
- branch -> koha-restful/Branch.pm

ETL-software (opensource):
- librecat/catmandu
