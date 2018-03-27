#!/bin/bash
runcode() {
  CONTAINER='';
  VOLUME='';
  COMMAND='bash';
  ARGS=();

  for i in $@; do ARGS+=($i); done;
  for (( i=0;i<${#ARGS[@]};i++ )) do
      case "${ARGS[i]}" in
          node)
              CONTAINER="node";;
          go)
              CONTAINER="golang";;
          --volume)
              DIRECTORY=${ARGS[i+1]};
              VOLUME="-v $DIRECTORY:/app";;
          --command)
              COMMAND=${ARGS[i+1]};;
          *)
              break;;
      esac
  done;

  if [ -z $CONTAINER ]
  then
      echo "No container specified!";
      exit 1;
  fi
  docker run -ti --rm $VOLUME $CONTAINER $COMMAND;
}
