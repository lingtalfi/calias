#!/bin/bash



#----------------------------------------
# Create Alias v1.0
#----------------------------------------
# 2015-10-03
# 
# The goal of this script is to make commands available system wide rapidly.
# 
# This script will automatically create a symlink for you and put it in your /usr/local/bin.
# If the symlink already exists, you need to use -f option to force override.
# The -v option is verbose
# 
# Usage:
# 
#       calias <realScript> <symlinkName>
# 
# Example:
#       
#       calias moderator.sh mymod
# 
# Options:
#       -v: turn verbose mode on
#       -f: if turned on, will remove any existing symlink with path <symlinkName>
# 
# 
# 
# 



programName=calias
force=0
verbose=0
programPath=$0
commandDir=/usr/local/bin


error (){
    echo "$programName: fatal: $1"
    exit 1
}
log (){
    if [ 1 -eq $verbose ]; then
        echo "$programName: $1"
    fi
}

help (){

cat <<EOF
    Usage: $0 [options] <realScript> <symlinkName>
    
    Options:
        -f:     force creation of symlink: if a file with the same name exists,
                it will be removed and the new symlink created.
        -v:     verbose
                        
EOF
exit

}



# https://github.com/lingtalfi/printScriptDir
printScriptDir (){  
    # case of a symbolic link
    if [ -h "$1" ]; then
        # the following readlink command works at least on MacOsX
        realPath=$(readlink "$1") 
        realDir=$(dirname "$realPath")
    # case of an absolute path        
    elif [ '/' = "${1:0:1}" ]; then
        realDir=$(dirname "$1")
    # case of an assumed relative path        
    else
        realPath="$(pwd)/$1"
        realDir=$(dirname "$realPath")
        
        # normalize path
        pushd "$realDir" > /dev/null
        realDir=$(pwd)
        popd > /dev/null
    fi
    
    echo $realDir
}



#----------------------------------------
# Processing command line options
#----------------------------------------
while getopts :fv FLAG; do
  case $FLAG in
    f)  
      force=1
      ;;
    v)  
      verbose=1
      ;;
    \?) 
      help
      ;;
  esac
done

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.



if [ -n "$1" ]; then
    if [ -n "$2" ]; then
        scriptRelPath="$1"
        
        if [ '/' = "${scriptRelPath:0:1}" ]; then
            realScript=$scriptRelPath
        else
            curDir=$(printScriptDir "$programPath")
            realScript="$curDir/$scriptRelPath"
        fi
        
        symlinkName="$2"                        
        binLink="$commandDir/$symlinkName"
                                               
                                
        if [ -h "$binLink" ]; then
            
            if [ 0 -eq $force ]; then
                error "The file already exists: $binLink. Use -f option to remove it!"
            else
                log "overriding $binLink (-f option)"
                rm "$binLink"
            fi                   
        fi                   
        
        
        log "executing ln -s $realScript $binLink"
        ln -s "$realScript" "$binLink"             
             
    else
        help 
    fi     
else
    help 
fi 




