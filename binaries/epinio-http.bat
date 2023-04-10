setlocal
path %~dp0;%PATH%

kubectl delete -n epinio ingress/epinio-http

kubectl get -n epinio ingress/epinio -o json |^
jq .metadata.name=\"epinio-http\" |^
jq .metadata.annotations[\"traefik.ingress.kubernetes.io/router.entrypoints\"]=\"web\" |^
jq .metadata.labels[\"app.kubernetes.io/name\"]=\"epinio-http\" |^
jq .metadata.annotations[\"traefik.ingress.kubernetes.io/router.tls\"]=\"false\" |^
jq del(.metadata.annotations[\"traefik.ingress.kubernetes.io/router.tls\"]) |^
jq del(.spec.tls) |^
kubectl -n epinio apply -f -
