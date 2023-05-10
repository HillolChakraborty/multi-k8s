docker build -t hillolchakrabarty40/multi-client:latest -t hillolchakrabarty40/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hillolchakrabarty40/multi-server:latest -t hillolchakrabarty40/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hillolchakrabarty40/multi-worker:latest -t hillolchakrabarty40/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hillolchakrabarty40/multi-client:latest
docker push hillolchakrabarty40/multi-server:latest
docker push hillolchakrabarty40/multi-worker:latest

docker push hillolchakrabarty40/multi-client:$SHA
docker push hillolchakrabarty40/multi-server:$SHA
docker push hillolchakrabarty40/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hillolchakrabarty40/multi-server:$SHA
kubectl set image deployments/client-deployment client=hillolchakrabarty40/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hillolchakrabarty40/multi-worker:$SHA
