#!/bin/bash

KUBECTL="minikube kubectl --";

ENV=$1;
if [[ -z "${ENV}" ]]; then
	echo "Environment required [prod, hmol, test, dev] "
	exit;
fi;
if [[ ! -d $ENV ]]; then
	echo "Environment not found : " $ENV
fi;


echo "Recriando o ambiente :" ${ENV}
$KUBECTL delete -f ${ENV}/www-test.yml;
$KUBECTL delete -f ${ENV}/volumes/pv-source.yml;



$KUBECTL apply -f ${ENV}/volumes/pv-source.yml;
$KUBECTL apply  -f ${ENV}/www-test.yml;

echo "-----------------------------------------------------------------";
$KUBECTL get pods --watch