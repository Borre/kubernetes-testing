#!/bin/bash
kubectl delete service redis
kubectl delete service test-kubernetes
kubectl delete deployment redis
kubectl delete deployment test-kubernetes
kubectl delete hpa test-kubernetes
kubectl get pods
kubectl get deployments
kubectl get hpa
