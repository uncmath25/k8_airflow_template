.PHONY: clean setupk8 start stop reset

SHELL := /bin/bash

clean:
	@echo "*** Cleaning the repo... ***"
	rm -rf `find . -name __pycache__`
	rm -rf .pytest_cache

setupk8:
	@echo "*** Setting up k8 locally... ***"
	./scripts/install_k8.sh

start:
	@echo "*** Starting local minikube... ***"
	minikube start
	./scripts/install_docker_images.sh
	./k8/apply.sh
	@echo "Airflow webserver available at: $$(minikube service --url airflow-service)"

stop:
	@echo "*** Stopping local minikube... ***"
	minikube stop

reset: stop
	@echo "*** Resetting local minikube... ***"
	minikube delete
