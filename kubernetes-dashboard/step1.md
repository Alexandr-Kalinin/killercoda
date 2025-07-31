# Установка Kubernetes Dashboard

> Сервисы должны работать на всех интерфейсах (например 0.0.0.0), а не только на localhost.
<br>
> Сервисы должны быть доступны через HTTP, а **не** HTTPS.

## Установка кастомизированного K8s Dashboard

Установите кастомизированный YAML файл K8s Dashboard:

```plain
kubectl apply -f /root/dashboard.yaml
kubectl -n kubernetes-dashboard wait --for=condition=ready pod --all
```{{exec}}

## Модификации конфигурации

Изменения включают следующие аргументы:

```yaml
args:
- --namespace=kubernetes-dashboard
- --enable-skip-login
- --disable-settings-authorizer
- --enable-insecure-login
- --insecure-bind-address=0.0.0.0
```

и обновленный YAML файл сервиса:

```yaml
kind: Service
apiVersion: v1
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
spec:
  ports:
    - port: 9090
      targetPort: 9090
  selector:
    k8s-app: kubernetes-dashboard
```

## Создание пользователя и токена доступа

> В панели управления вы можете видеть ресурсы только в зависимости от разрешений токена: [подробнее](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)

Создайте ServiceAccount и используйте токен:

```plain
kubectl -n kubernetes-dashboard create sa admin-user
kubectl create clusterrolebinding admin-user --clusterrole cluster-admin --serviceaccount kubernetes-dashboard:admin-user
kubectl -n kubernetes-dashboard create token admin-user
```{{exec}}

## Настройка проброса портов

Далее нужно запустить port-forward:

```plain
kubectl -n kubernetes-dashboard port-forward service/kubernetes-dashboard 9090:9090 --address 0.0.0.0
```{{exec}}

## Доступ к панели управления

Теперь используйте выведенный в терминале токен для входа в:

[ДОСТУП К ПАНЕЛИ УПРАВЛЕНИЯ]({{TRAFFIC_HOST1_9090}}) или [ДОСТУП К ПОРТАМ]({{TRAFFIC_SELECTOR}})
