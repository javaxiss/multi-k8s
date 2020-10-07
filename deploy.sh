docker build -t javaxiss/multi-client:latest -t javaxiss/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t javaxiss/multi-server:latest -t javaxiss/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t javaxiss/multi-worker:latest -t javaxiss/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push javaxiss/multi-client:latest
docker push javaxiss/multi-server:latest
docker push javaxiss/multi-worker:latest

docker push javaxiss/multi-client:$GIT_SHA
docker push javaxiss/multi-server:$GIT_SHA
docker push javaxiss/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=javaxiss/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=javaxiss/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=javaxiss/multi-worker:$GIT_SHA