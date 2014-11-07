# LS.ETL
Load of example-data (test-data for manual user-testing) into ls.ext

Koha needs the following entities:
- branch
- item type
- patron category
- patron
- bibliographic data

## Process:
- Prepare or extract example data from source.
- If necessary transform example data. Use e.g. Catmandu importer
- Load (transformed) example data into Koha.
- Test that koha is in a legal state.

### Typcial scenario:
A csv-file is created manually, the file is input to a load-script that
utilizes importers in Catmandu to transform csv-records to json, which is
finally loaded into koha by posting them to the koha-restful api.

## EXTRACT
Is accomplished either as 
* a manually created (csv) file,
* custom jobs to dump records to file, or
* as a first step in the LOAD-job.

## TRANSFORM
Is often done as a step in the LOAD-job.

## LOAD
We utilize the import-functions in Koha to get the data into it. In general
there are three mechanisms to support this:
* by api,
* by SQL,
* by HTML. 

We prefer loading by api.

Mapping of entities to import-function in Koha:
Entity | Mechanism | Name
------ | --------- | ----
branch | api       | koha-restful/Branch.pm


## ETL-software (opensource):
- librecat/catmandu
