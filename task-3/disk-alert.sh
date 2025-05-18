#!/bin/bash

# Parameters (replace with env vars or pass as arguments)
SMTP_SERVER="$SMTP_SERVER"
SMTP_PORT="587"
SMTP_USER="$SMTP_USER"
SMTP_PASSWORD="$SMTP_PASSWORD"
RECIPIENT="$RECIPIENT"
SENDER="$SENDER"
THRESHOLD=80



USAGE=$(df -h /dev/nvme0n1p7 | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Использование диска находится на уровне ${USAGE}%! Отправляю предупреждение..."

    
    curl \
  --url "smtp://${SMTP_SERVER}:${SMTP_PORT}" \
  --ssl-reqd \
  --mail-from "${SENDER}" \
  --mail-rcpt "${RECIPIENT}" \
  --user "${SMTP_USER}:${SMTP_PASSWORD}" \
  --upload-file - <<EOF
From: ${SENDER}
To: ${RECIPIENT}
Subject: Disk Space Alert!
Content-Type: text/plain; charset=UTF-8

Warning: Disk usage is at ${USAGE}% on $(hostname).
EOF

    echo "Предупреждение отправлено на ${RECIPIENT}."
else
    echo "Использование диска (${USAGE}%) ниже порогового значения (${THRESHOLD}%)."
fi
