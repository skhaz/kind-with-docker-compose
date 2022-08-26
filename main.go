package main

import (
	"context"
	"fmt"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	ctrl "sigs.k8s.io/controller-runtime"
)

var ctx = context.Background()

func main() {
	clientset := kubernetes.NewForConfigOrDie(ctrl.GetConfigOrDie())

	list, err := clientset.AppsV1().Deployments("default").List(ctx, metav1.ListOptions{})
	if err != nil {
		panic(err)
	}

	for _, item := range list.Items {
		fmt.Printf("Deploy %v\n", item)
	}
}
