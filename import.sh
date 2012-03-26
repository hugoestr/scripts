#!/usr/bin/bash
# This script automates the data insertion handling


#functions
function set_up {
  #for testing. Remove this section when ready to do.
  rm -fr work
  rm -fr unzipped
  
  mkdir work
  mkdir unzipped
  
  server=""
  user=""
  password=""

}

function extract_zip {
  7za e $1 -owork
}

function prepare_files {
  for f in $(ls work/[12][0-9][0-9][0-9]*.csv); do

    if [[ "$f" =~ VAX ]]; then
      cp $f work/VAERSVAX.csv  
    fi
    
    if [[ "$f" =~ SYMPTOMS ]]; then
      ruby ./fix_column_quotes.rb $f "2 4 6 8 10"  > work/VAERSSYMPTOMS.csv  
    fi

    if [[ "$f" =~ DATA ]]; then
      ruby ./fix_column_quotes.rb $f "8 21 24 26 27"  > work/VAERSDATA.csv  
    fi
    
  done
}

function import_to_sql {
  import_files=$(ls work/VAERS*.csv | sort)

  for i in $import_files; do
    no_extension=$(expr match $i '\(^.*\)\.')
    table=${no_extension:5}
    echo "bcp $table in $i 'options'"
    bcp vaers.dbo.$table in $i -eerrors.log -F1 -b200 -m500 -c -t, -S$server -U$user -P$password
  done

}

function get_year {
  f=$(ls work/[12][0-9][0-9][0-9]*.csv | head -1)
  year=${f:5:4}
}

function move_source_files {
  source_files=$(ls work/[12][0-9][0-9][0-9]*.csv)
  get_year
  mkdir unzipped/$year
  for f in $source_files; do
    file=${f:5}
    mv $f unzipped/$year/$file
  done
}

function clean_up {
  rm -fr work
}

function main {
  set_up

  source_folder=$1
  zip_packages=$(ls $source_folder | sort)

  for package in $zip_packages; do
    package_path="$source_folder/$package"

    extract_zip $package_path
    prepare_files
    import_to_sql
    move_source_files
  done

  clean_up
}

#execution
main $1
