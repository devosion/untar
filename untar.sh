#!/bin/bash
# a script for detecting and unpacking tar archives


# display usage
DisplayUsage () {

    printf "USAGE: untar.sh [tar_file]
Currently supports .tar.gz, .tar.bz2, and .tar.xz.\n"
}

# processes the file argument and unpacks it via tar and
# the compression type
ProcessArchive() {

    # grab passed argument
    tar_file=$1

    # grab last field 
    tar_type=$(echo $tar_file | awk -F'.' '{print $NF}')

    # check for a valid tar file; if not then exit
    if [[ $(echo $tar_file | awk -F'.' '{print $(NF-1)}') != "tar" ]]; then
        printf "%s\n" 'Not a valid tar file. Exiting.'
        exit 1

    fi

    # check for empty string, or .tar file
    if [[ -z $tar_type ]]; then

        tar xvf ${tar_file}

    # for .tar.gz files
    elif [[ $tar_type == "gz" ]]; then

        option="z"
        tar xvf${option} ${tar_file}

    # for .tar.bz2 files
    elif [[ $tar_type == "bz2" ]]; then

        option="j"
        tar xvf${option} ${tar_file}

    # for tar.xz files
    elif [[ $tar_type == "xz" ]]; then
        
        option="J"
        tar xvf${option} ${tar_file}

    # catch all for anything else
    else
        printf "%s\n" 'Unsupported file detected. Exiting.'
    fi

}

# if no passed arguments then display usage and exit
if [[ -z $1 ]]; then
    DisplayUsage 
    exit 1
fi

ProcessArchive $1

