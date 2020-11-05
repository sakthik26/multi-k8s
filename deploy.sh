docker build -t sakthik26/multi-client:latest -t sakthik26/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sakthik26/multi-server:latest -t sakthik26/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sakthik26/multi-worker:latest -t sakthik26/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sakthik26/multi-client:latest
docker push sakthik26/multi-server:latest
docker push sakthik26/multi-worker:latest

docker push sakthik26/multi-client:$SHA
docker push sakthik26/multi-server:$SHA
docker push sakthik26/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sakthik26/multi-server:$SHA
kubectl set image deployments/client-deployment client=sakthik26/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sakthik26/multi-worker:$SHA