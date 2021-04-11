# Task 2

This documentation does not explain the written code,
please make sure to understand the usage of these files using the official [Kubernetes documentation](https://kubernetes.io/)

***Please also make sure to be in the correct folder to run a command***

## Namespace

You can find details of K8S namespaces [here](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

First create a namespace with the following command:
```
microk8s kubectl apply -f namespace/namespace.yaml
```
To test the namespace:
```
microk8s kubectl get ns [NAME]
```

Now we have created the namespaces our app will use, the **namespace** name is `cowsay`

## Service

You can find details of K8S services [here](https://kubernetes.io/docs/concepts/services-networking/service/)

The next step is to create the service our app will use.

Apply your service configuration this way:
```
microk8s kubectl apply -f service/service.yaml
```
It's important to note the `nodePort` field in the file, since the app will be accessed on that port later.
You can check the services' status with
```
microk8s kubectl get svc -n [NAMESPACE]
```
## Deployment

You can find details of K8S deployments [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

Lastly we have to create a deployment for our app. You can do this by running the
```
microk8s kubectl apply -f deployment/deployment.yaml
```
command.

## Test the output

If everything is correct, you should be able to acces our app following these steps.

> 1st

Check the status of your kubernetes nodes
``` microk8s kubectl get no -o wide ```
You should be able to see **your** nodes there, in **my case** this is the output:
```
NAME         STATUS     ROLES    AGE    VERSION                     INTERNAL-IP     EXTERNAL-IP   OS-IMAGE        KERNEL-VERSION       CONTAINER-RUNTIME
pop-os       NotReady   <none>   157d   v1.19.3-34+a56971609ff35a   192.168.8.110   <none>        Pop!_OS 20.10   5.8.0-7630-generic   containerd://1.3.7
gregs-yoga   Ready      <none>   137d   v1.19.9-34+69a399560680be   192.168.1.71    <none>        Pop!_OS 20.10   5.8.0-7642-generic   containerd://1.3.7
```
So the IP address I will use for the `curl` command is 192.168.1.71, and the port address will be the one we specified in the `nodePort` attribute earlyer.

> 2nd 

Given the ```curl -L 192.168.1.71:32000``` command, we should see the following:

```
curl -L 192.168.1.71:32000
```
```
 ____________________________________
/ The real problem is not whether    \
| machines think but whether men do. |
\ -B.F. Skinner-                     /
 ------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
                
```
curl -L 192.168.1.71:32000
```
```
 ________________________________________
/ Hardware: the parts of a computer that \
\ can be kicked. -Jeff Pesis-            /
 ----------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
