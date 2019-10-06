[
    {
        "name": "${db_name}",
        "image": "redis",
        "networkMode": "awsvpc",
        "portMappings": [
            {
                "containerPort": 6379,
                "hostPort": 6379
            }
        ]
    },
    {
        "name": "api",
        "image": "${app_image}",
        "networkMode": "awsvpc",
        "portMappings": [
            {
                "containerPort": ${app_port},
                "hostPort": ${app_port}
            }
        ],
        "environment": [
            {
                "name": "REDIS_ENDPOINT",
                "value": "localhost"
            },
            {
                "name": "REDIS_PORT",
                "value": "${db_port}"
            }
        ]
    }
]
