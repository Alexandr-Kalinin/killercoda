#!/bin/bash

# Проверка на наличие Pod с label-ом kubernetes-dashboard
POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l k8s-app=kubernetes-dashboard -o jsonpath="{.items[0].metadata.name}")

if [[ -z "$POD_NAME" ]]; then
  echo "❌ Pod 'kubernetes-dashboard' не найден в namespace 'kubernetes-dashboard'"
  exit 1
fi

STATUS=$(kubectl get pod "$POD_NAME" -n kubernetes-dashboard -o jsonpath="{.status.phase}")

if [[ "$STATUS" == "Running" ]]; then
  echo "✅ Pod '$POD_NAME' работает"
  exit 0
else
  echo "❌ Pod '$POD_NAME' найден, но не в статусе Running. Статус: $STATUS"
  exit 1
fi
