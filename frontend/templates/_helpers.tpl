{{- define "frontend-name" -}}
{{ .Chart.Name }}
{{- end -}}

{{- define "frontend-namespace" -}}
{{ .Values.namespace.name }}
{{- end -}}