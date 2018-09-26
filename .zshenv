# Swagger ui preview
function swagger_yaml2json() {
  docker run -v "$(pwd)":/docs swaggerapi/swagger-codegen-cli generate -i /docs/"$1" -l swagger -o /docs
}
function swagger_ui_start() {
    CONTAINER_NAME=${1:-swagger-ui-preview}
    VOLUME=$(echo $(pwd) | tr "/" "_")
    echo $VOLUME
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "exited, cleaning"
            # cleanup
            # echo removing: 
            docker rm $CONTAINER_NAME
        fi
        # run the container
        docker run --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/$VOLUME/swagger.json -v "$(pwd)":/$VOLUME swaggerapi/swagger-ui
    elif [ "$(docker ps -aq -f status=running -f volume=/$VOLUME -f name=$CONTAINER_NAME)" ]; then
            # check volumn TODO
            echo $CONTAINER_NAME "is already running in dir: $(pwd)"
    else
            echo "other dir: $VOLUME, removing"
            docker rm -f $CONTAINER_NAME
            docker run --rm --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/$VOLUME/swagger.json -v "$(pwd)":/$VOLUME swaggerapi/swagger-ui
    fi
}
function swagger_preview() {
    SOURCE=${1:-swagger.yaml}
    $(swagger_yaml2json $SOURCE)
    swagger_ui_start
}
