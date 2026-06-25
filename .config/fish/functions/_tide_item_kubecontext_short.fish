function _tide_item_kubecontext_short
    command -q kubectl; or return

    set -l context (kubectl config current-context 2>/dev/null)
    test -n "$context"; or return

    set -l namespace (kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    test -n "$namespace"; or set namespace default

    set -l short_context (string replace -r '^arn:aws:eks:[^:]+:[0-9]+:cluster/' '' -- $context)
    set short_context (string replace -r '^gke_[^_]+_[^_]+_' '' -- $short_context)

    if test "$namespace" = default
        _tide_print_item kubecontext_short $tide_kubectl_icon' ' $short_context
    else
        _tide_print_item kubecontext_short $tide_kubectl_icon' ' $short_context'/'$namespace
    end
end
