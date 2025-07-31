#!/bin/bash

# Проверяем наличие Pod'а с нужным label в namespace kubernetes-dashboard
POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l k8s-app=kubernetes-dashboard -o jsonpath="{.items[0].metadata.name}")

if [[ -z "$POD_NAME" ]]; then
  echo "❌ Pod 'kubernetes-dashboard' не найден в namespace 'kubernetes-dashboard'"
  exit 1
fi

# Проверяем статус Pod'а
STATUS=$(kubectl get pod "$POD_NAME" -n kubernetes-dashboard -o jsonpath="{.status.phase}")

if [[ "$STATUS" != "Running" ]]; then
  echo "❌ Pod найден, но его статус: $STATUS (ожидается 'Running')"
  exit 1
fi

# Всё успешно
echo "✅ Kubernetes Dashboard работает!"

# Вывод кода подтверждения
echo ""
echo "🔑 Код подтверждения:"
echo "TaskComplete123"
echo ""
echo "📎 Скопируйте этот код и отправьте его преподавателю."

exit 0
