# Task 2

***Important:** This is the copy of the `README.md` file in [my repository](https://github.com/D3w4r/hakap), you can find the source files there! I can also submit a copy of this file in hungarian if you want, english is just for the consistency of the repository.*

This documentation does not fully explain the written code (exact meaning of words in config files),
please refer to the official [Kubernetes documentation](https://kubernetes.io/)

***Please also make sure to be in the correct folder to run a command***

## Namespace

You can find details of K8S namespaces [here](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

First create a namespace with the following command:

```
microk8s kubectl apply -f namespace/namespace.yaml
```

To test the existance of the namespace:

```
microk8s kubectl get ns [NAME]
```

Now we have created the namespaces our app will use, the **namespace** name is `cowsay`

## Deployment

You can find details of K8S deployments [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

We have to create a deployment for our app. I used my previously created `cowsay container`, which you can acces [here](https://hub.docker.com/layers/140577465/d3w4r/hakap/cowsay/images/sha256-e99d1ded13c64ab58d13fb434fe7040efa640a82ef478f9b6742a014b4421736?context=explore).

This container uses a shared volume named `shared` in the root directory. In your `deployment.yaml` you have to specify the correct path for this volume. It is also required to create a mount for the webserver too, which will be located at `/usr/share/nginx/html`. The standard port for the webserver is `80`.

You can apply your configuration by running the

```
microk8s kubectl apply -f deployment/deployment.yaml
```

## Service

You can find details of K8S services [here](https://kubernetes.io/docs/concepts/services-networking/service/)

The next step is to create the service our app will use. This way we can acces our app from `nodePort: 32000` on the outside (from inside the cluster it is accessed on `port: 8080` ). In my solution I am using `LoadBalancer` as service type.

Apply your service configuration this way:

```
microk8s kubectl apply -f service/service.yaml
```

It's important to note the `nodePort` field in the file, since the app will be accessed on that port later.

You can check the services' status with

```
microk8s kubectl get svc -n [NAMESPACE]
```

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

So the IP address I will use for the `curl` command is 192.168.1.71, and the port address will be the one we specified in the `nodePort` attribute earlier.

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
