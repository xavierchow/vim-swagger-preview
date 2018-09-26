# Swagger ui preview
function swagger_yaml2json() {
  TMP_DIR="/tmp/vim-swagger-preview/"
  docker run -v "$(pwd)":/docs -v $TMP_DIR:/out swaggerapi/swagger-codegen-cli generate -i /docs/"$1" -l swagger -o /out
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
        docker run --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/docs/swagger.json -v $TMP_DIR:/docs swaggerapi/swagger-ui
    elif [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "is already running"
    fi
}
function swagger_preview() {
    SOURCE=${1:-swagger.yaml}
    $(swagger_yaml2json $SOURCE)
    swagger_ui_start
}
