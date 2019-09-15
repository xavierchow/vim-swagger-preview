# Swagger ui preview
function swagger_yaml2json() {
  TMP_DIR="/tmp/vim-swagger-preview/"
  LOG=$TMP_DIR"validate.log"
  docker run  --rm -v $(pwd):/docs openapitools/openapi-generator-cli validate -i /docs/"$1" > $LOG 2>&1
  count=$(wc -l < $LOG)
  if [[ $count -gt 2 ]]; then
    # File exists and has a size greater than zero
    return 1
  else
    if grep -q "docker daemon running" $LOG; then
      return 2
    else
      # dump the stdout stderr to file otherwise the caller function complains
      docker run -v $(pwd):/docs -v $TMP_DIR:/out openapitools/openapi-generator-cli generate -i /docs/"$1" -g openapi -o /out > $LOG 2>&1
      # clear the log file
      cp /dev/null $LOG
      # https://github.com/swagger-api/swagger-codegen/issues/9140
     # docker run -v $(pwd):/docs -v $TMP_DIR:/out swaggerapi/swagger-codegen-cli-v3:3.0.9 generate -i /docs/"$1" -l openapi -o /out > /dev/null 2>&1
      return 0

    fi
  fi
}
function swagger_ui_start() {
    CONTAINER_NAME=${1:-swagger-ui-preview}
    TMP_DIR="/tmp/vim-swagger-preview/"
    # VOLUME=$(echo $(pwd) | tr "/" "_")
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "exited, cleaning"
            # cleanup
            # echo removing: 
            docker rm $CONTAINER_NAME
        fi
        # run the container
        docker run --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/docs/openapi.json -v $TMP_DIR:/docs swaggerapi/swagger-ui
    elif [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "is already running"
    fi
}
function swagger_preview() {
    TMP_DIR="/tmp/vim-swagger-preview/"
    LOG=$TMP_DIR"validate.log"
    SOURCE=${1:-swagger.yaml}
    $(swagger_yaml2json $SOURCE)
    YAML2JSON_RETURN_CODE=$?
    if [ "$YAML2JSON_RETURN_CODE" -eq "0" ]; then
      swagger_ui_start
    else
      cat $LOG
      echo "Converting to json failed!"
    fi
}
