docker build -t burningserenity/multi-client:latest -t burningserenity/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t burningserenity/multi-server:latest -t burningserenity/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t burningserenity/multi-worker:latest -t burningserenity/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push burningserenity/multi-client:latest
docker push burningserenity/multi-client:$SHA
docker push burningserenity/multi-server:latest
docker push burningserenity/multi-server:$SHA
docker push burningserenity/multi-worker:latest
docker push burningserenity/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=burningserenity/multi-server:$SHA
kubectl set image deployments/client-deployment server=burningserenity/multi-client:$SHA
kubectl set image deployments/worker-deployment server=burningserenity/multi-worker:$SHA
