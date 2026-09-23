{{- $critical := 0 -}}
{{- $high := 0 -}}
{{- $medium := 0 -}}
{{- $low := 0 -}}
{{- $unknown := 0 -}}
{{- $total := 0 -}}

{{- range . -}}
  {{- range .Vulnerabilities -}}
    {{- $total = add $total 1 -}}
    {{- if eq .Severity "CRITICAL" }}{{ $critical = add $critical 1 }}{{ end -}}
    {{- if eq .Severity "HIGH" }}{{ $high = add $high 1 }}{{ end -}}
    {{- if eq .Severity "MEDIUM" }}{{ $medium = add $medium 1 }}{{ end -}}
    {{- if eq .Severity "LOW" }}{{ $low = add $low 1 }}{{ end -}}
    {{- if eq .Severity "UNKNOWN" }}{{ $unknown = add $unknown 1 }}{{ end -}}
  {{- end -}}
{{- end -}}

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Trivy Security Report</title>

<style>
    :root {
        --bg: #0b0f14;
        --panel: #111820;
        --panel-hover: #151e28;
        --border: #25303b;
        --text: #e6edf3;
        --muted: #8b98a5;

        --critical: #ff4d4f;
        --high: #ff8a3d;
        --medium: #f2c94c;
        --low: #4da3ff;
        --unknown: #8b98a5;

        --green: #3fb950;
    }

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        background: var(--bg);
        color: var(--text);
        font-family:
            Inter,
            -apple-system,
            BlinkMacSystemFont,
            "Segoe UI",
            sans-serif;
        font-size: 14px;
    }

    .container {
        max-width: 1500px;
        margin: auto;
        padding: 40px 24px;
    }

    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 32px;
    }

    .title {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .title-icon {
        width: 38px;
        height: 38px;
        border-radius: 10px;
        background: #17212b;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }

    h1 {
        margin: 0;
        font-size: 24px;
        font-weight: 600;
        letter-spacing: -0.4px;
    }

    .subtitle {
        color: var(--muted);
        margin-top: 4px;
    }

    .badge {
        border: 1px solid var(--border);
        background: var(--panel);
        color: var(--muted);
        padding: 7px 12px;
        border-radius: 8px;
        font-size: 12px;
    }

    /* Summary */

    .summary {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 14px;
        margin-bottom: 32px;
    }

    .card {
        background: var(--panel);
        border: 1px solid var(--border);
        border-radius: 10px;
        padding: 18px;
    }

    .card-label {
        color: var(--muted);
        font-size: 12px;
        margin-bottom: 8px;
    }

    .card-value {
        font-size: 28px;
        font-weight: 600;
    }

    .critical {
        color: var(--critical);
    }

    .high {
        color: var(--high);
    }

    .medium {
        color: var(--medium);
    }

    .low {
        color: var(--low);
    }

    .unknown {
        color: var(--unknown);
    }

    /* Targets */

    .target {
        margin-bottom: 28px;
    }

    .target-header {
        display: flex;
        justify-content: space-between;
        align-items: center;

        background: var(--panel);
        border: 1px solid var(--border);

        padding: 15px 18px;

        border-radius: 10px 10px 0 0;
    }

    .target-name {
        font-weight: 600;
        color: var(--text);
    }

    .target-count {
        color: var(--muted);
        font-size: 12px;
    }

    /* Table */

    .table-wrapper {
        overflow-x: auto;

        border: 1px solid var(--border);
        border-top: none;

        border-radius: 0 0 10px 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 900px;
    }

    th {
        text-align: left;
        padding: 12px 16px;

        color: var(--muted);

        font-size: 11px;
        font-weight: 600;

        text-transform: uppercase;
        letter-spacing: 0.5px;

        background: #0e141b;

        border-bottom: 1px solid var(--border);
    }

    td {
        padding: 14px 16px;

        border-bottom: 1px solid #1d2731;

        vertical-align: top;
    }

    tr:last-child td {
        border-bottom: none;
    }

    tr:hover {
        background: var(--panel-hover);
    }

    .cve {
        font-family: monospace;
        font-size: 13px;
        font-weight: 600;

        color: #79c0ff;

        text-decoration: none;
    }

    .cve:hover {
        text-decoration: underline;
    }

    .package {
        font-weight: 500;
    }

    .version {
        color: var(--muted);
        font-family: monospace;
        font-size: 12px;
    }

    .arrow {
        color: #536170;
        padding: 0 5px;
    }

    .fixed {
        color: var(--green);
    }

    .severity {
        display: inline-block;

        padding: 4px 8px;

        border-radius: 6px;

        font-size: 11px;
        font-weight: 700;

        letter-spacing: 0.3px;
    }

    .severity-critical {
        color: var(--critical);
        background: rgba(255, 77, 79, 0.10);
    }

    .severity-high {
        color: var(--high);
        background: rgba(255, 138, 61, 0.10);
    }

    .severity-medium {
        color: var(--medium);
        background: rgba(242, 201, 76, 0.10);
    }

    .severity-low {
        color: var(--low);
        background: rgba(77, 163, 255, 0.10);
    }

    .severity-unknown {
        color: var(--unknown);
        background: rgba(139, 152, 165, 0.10);
    }

    .description {
        color: var(--muted);
        line-height: 1.5;
        max-width: 500px;
    }

    .empty {
        text-align: center;
        padding: 60px 20px;

        color: var(--green);
    }

    .empty-icon {
        font-size: 32px;
        margin-bottom: 12px;
    }

    footer {
        margin-top: 35px;

        color: var(--muted);

        text-align: center;

        font-size: 12px;
    }

    @media (max-width: 900px) {
        .summary {
            grid-template-columns: repeat(2, 1fr);
        }

        header {
            align-items: flex-start;
            gap: 15px;
            flex-direction: column;
        }
    }

    @media (max-width: 500px) {
        .container {
            padding: 24px 14px;
        }

        .summary {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>

<body>

<div class="container">

<header>
    <div class="title">
        <div class="title-icon">🛡</div>

        <div>
            <h1>Trivy Security Report</h1>
            <div class="subtitle">
                Filesystem vulnerability scan
            </div>
        </div>
    </div>

    <div class="badge">
        Generated by Trivy
    </div>
</header>


<!-- SUMMARY -->

<div class="summary">

    <div class="card">
        <div class="card-label">Critical</div>
        <div class="card-value critical">
            {{ $critical }}
        </div>
    </div>

    <div class="card">
        <div class="card-label">High</div>
        <div class="card-value high">
            {{ $high }}
        </div>
    </div>

    <div class="card">
        <div class="card-label">Medium</div>
        <div class="card-value medium">
            {{ $medium }}
        </div>
    </div>

    <div class="card">
        <div class="card-label">Low</div>
        <div class="card-value low">
            {{ $low }}
        </div>
    </div>

    <div class="card">
        <div class="card-label">Total vulnerabilities</div>
        <div class="card-value">
            {{ $total }}
        </div>
    </div>

</div>


<!-- RESULTS -->

{{- range . }}

<div class="target">

    <div class="target-header">

        <div class="target-name">
            {{ .Target }}
        </div>

        <div class="target-count">
            {{ len .Vulnerabilities }} vulnerabilities
        </div>

    </div>


    {{- if .Vulnerabilities }}

    <div class="table-wrapper">

        <table>

            <thead>
                <tr>
                    <th>Severity</th>
                    <th>CVE</th>
                    <th>Package</th>
                    <th>Installed</th>
                    <th>Fixed</th>
                    <th>Description</th>
                </tr>
            </thead>

            <tbody>

            {{- range .Vulnerabilities }}

                <tr>

                    <td>

                        {{- if eq .Severity "CRITICAL" }}
                        <span class="severity severity-critical">
                            CRITICAL
                        </span>

                        {{- else if eq .Severity "HIGH" }}
                        <span class="severity severity-high">
                            HIGH
                        </span>

                        {{- else if eq .Severity "MEDIUM" }}
                        <span class="severity severity-medium">
                            MEDIUM
                        </span>

                        {{- else if eq .Severity "LOW" }}
                        <span class="severity severity-low">
                            LOW
                        </span>

                        {{- else }}
                        <span class="severity severity-unknown">
                            {{ .Severity }}
                        </span>
                        {{- end }}

                    </td>


                    <td>

                        {{- if .PrimaryURL }}

                        <a
                            class="cve"
                            href="{{ .PrimaryURL }}"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            {{ .VulnerabilityID }}
                        </a>

                        {{- else }}

                        <span class="cve">
                            {{ .VulnerabilityID }}
                        </span>

                        {{- end }}

                    </td>


                    <td>
                        <div class="package">
                            {{ .PkgName }}
                        </div>
                    </td>


                    <td>
                        <span class="version">
                            {{ .InstalledVersion }}
                        </span>
                    </td>


                    <td>

                        {{- if .FixedVersion }}

                        <span class="version fixed">
                            {{ .FixedVersion }}
                        </span>

                        {{- else }}

                        <span class="version">
                            Not fixed
                        </span>

                        {{- end }}

                    </td>


                    <td>

                        <div class="description">
                            {{ .Title }}
                        </div>

                    </td>

                </tr>

            {{- end }}

            </tbody>

        </table>

    </div>

    {{- else }}

    <div class="empty">

        <div class="empty-icon">
            ✓
        </div>

        No vulnerabilities detected

    </div>

    {{- end }}

</div>

{{- end }}


<footer>
    Security report generated by Trivy
</footer>

</div>

</body>
</html>