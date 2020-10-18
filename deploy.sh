docker build -t jchen96/multi-client:latest -t jchen96/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jchen96/multi-server:latest -t jchen96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jchen96/multi-worker:latest -t jchen96/multi-worker:$SHA -f ./server/Dockerfile ./worker
docker push jchen96/multi-client:latest 
docker push jchen96/multi-server:latest
docker push jchen96/multi-worker:latest

docker push jchen96/multi-client:$SHA
docker push jchen96/multi-server:$SHA
docker push jchen96/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jchen96/multi-server:$SHA
kubectl set image deployments/client-deployment client=jchen96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jchen96/multi-worker:$SHA