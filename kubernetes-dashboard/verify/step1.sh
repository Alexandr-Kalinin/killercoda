#!/bin/bash

echo "Проверка запуска Dashboard..."

POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l k8s-app=kubernetes-dashboard -o jsonpath="{.items[0].metadata.name}")

if [[ -z "$POD_NAME" ]]; then
  echo "❌ Pod не найден"
  exit 1
fi

STATUS=$(kubectl get pod "$POD_NAME" -n kubernetes-dashboard -o jsonpath="{.status.phase}")

if [[ "$STATUS" != "Running" ]]; then
  echo "❌ Pod найден, но статус: $STATUS"
  exit 1
fi

echo "✅ Всё хорошо!"
echo ""
echo "Код подтверждения:"
echo "TaskComplete123"

echo "TaskComplete123" > /root/completion-code.txt
cat /root/completion-code.txt
