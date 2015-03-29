New commands
----------------------------------------

* SWSqlExecuteCurrent! *DONE*
* SWSqlExecuteSelected! *DONE*
* SWSqlExecuteAll! *DONE*

* SWSqlAutocompletePersist <name>
* SWSqlAutocompleteLoad <name>
* SWSqlAutocomplete!

New options
----------------------------------------

* add the possibility to have -- BEFORE and -- AFTER comments in buffers
  *DONE* for before
* add commands to be executed globally on all sql buffers on load and on exit
* autocomplete to swsqlautocompleteload with the files from the cache folder
* add to the SWDbExplorer command the possibility to also select a database
  explorer configuration (this should be stored in resources folder). Uppon
  selection, the system will source this file instead of dbexplorer.vim
