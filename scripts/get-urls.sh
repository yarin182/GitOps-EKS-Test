#!/bin/bash

echo "Getting AWS ALB URL for Istio IngressGateway..."
echo "================================================"

# Get the external hostname of the AWS ALB
ALB_HOSTNAME=$(kubectl get ingress istio-ingressgateway -n istio-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$ALB_HOSTNAME" ]; then
    echo "❌ ALB hostname not found. The ALB might still be provisioning..."
    echo "Check the ingress status:"
    kubectl get ingress istio-ingressgateway -n istio-ingress
    exit 1
fi

echo "✅ AWS ALB URL: $ALB_HOSTNAME"
echo ""
echo "🌐 Application URLs:"
echo "   ArgoCD UI:      http://$ALB_HOSTNAME/argocd"
echo "   Prometheus UI:  http://$ALB_HOSTNAME/prometheus"
echo ""
echo "📋 To check if the ingress is ready:"
echo "   kubectl get ingress istio-ingressgateway -n istio-ingress"
echo ""
echo "🔍 To check Istio Gateway and VirtualService status:"
echo "   kubectl get gateway -n argocd"
echo "   kubectl get virtualservice -n argocd"
echo "   kubectl get gateway -n monitor"
echo "   kubectl get virtualservice -n monitor" 