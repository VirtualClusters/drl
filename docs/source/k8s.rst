
Start/Stop
-------------------------------------------------------------------------------

Simplest way to start / stop::

        kubectl run nginx --image=nginx --replicas=5

        kubectl delete rc nginx

.yaml is used to get information of k8s service,

Start or Stop can be done with a template file e.g.::

        kubectl create -f nginx.yaml

        kubectl stop -f nginx.yaml
