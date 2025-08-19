#!/usr/bin/env bash
# Two-Key Deploy (ADR-008): a money-path deploy requires two DISTINCT approvers.
set -euo pipefail

SERVICE="${1:?service required}"
APPROVERS="${TWO_KEY_APPROVERS:-}"  # comma-separated approver handles

case "$SERVICE" in
  tollgate|ledger-service)
    count=$(echo "$APPROVERS" | tr ',' '\n' | sort -u | grep -c .)
    if [[ "$count" -lt 2 ]]; then
      echo "Two-Key Deploy (ADR-008): money-path deploy needs two distinct approvers." >&2
      exit 3
    fi
    ;;
esac
