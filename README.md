# n3 DevOps Test

## Mini Rest API (api.py)
Write a python3 script that starts up a RESTfull application and listen to HTTP request on port 5000. Use redis to store data .
You must create two endpoints ​/key ​and​ /key/<KEY>​ which support two verbs:

- PUT /key​: create a redis key with the key/value coming from the body.

The below command must have the similar output than ​"redis-cli set key1 value1" curl -XPUT h​ ttp://HOST/key​ -H 'content-type: application/json' -d '{"key": "key1", "value":
"value1"}'
On success reply a 202 status and 500 in case of an error.

- GET /key/<KEY>​: will retrieve the key name and value in the following json format: '{"key": "key1", "value": "value1"}' with a status code of 200. If the key can not be found you must reply a 404 with no data.

### Solution:
First, I built the redis server by using docker. Assuming I do not have to install the docker engine on the machine, I ran the following commands.

```
docker pull redis
docker run -d --name=redis_test_n3hub -p 6379:6379 redis
```

Second, I wrote the api.py to handle the tasks (with flask and redis).  To run it, run the following commands

```
pip3 install -r requirement.txt 
python3 api.py
```
It will runs on port 5000 by default.  Edit the port if you see fit.


## Dockerfile
Create a Dockerfile which is running the project created in step 1.

### Solution:
See the api.dockerfile for the details.  

To Run it without docker compose...

```
docker run -it --name=api_test --link=redis_test_n3hub:database --env-file=api.env -p 5000:5000 n3hub_api
```

## Docker-compose file
Create a docker-compose file which will allow us to bring the project up. We should be able to query the api via ​http://localhost:5000​. Redis must not run in the same container the python project

### Solution:
See docker-compose.yml for details

Run the following command to build/rebuild
```
docker-compose up --build
```


## Terraform AWS ECS
Create a terraform directory which will contain the configuration files and bring the project live into Amazon ECS.
Bonus: Use remote state file.

### Solution:
Inside the terraform folder, run the following commands (assume you have setup the access key and the secret key)
```
terraform init
terraform plan -out=n3.plan
terraform apply "n3.plan"
```
To clean up
```
terraform destroy
```

