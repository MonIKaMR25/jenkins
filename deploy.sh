#! /bin/bash

ssh ubuntu@165.22.3.56 << EOF
  # Diagnóstico del sistema
  echo "=== System Info ==="
  cat /etc/os-release
  
  echo "=== SSH Services ==="
  sudo systemctl list-units --type=service | grep ssh || echo "No SSH services found"
  sudo systemctl status sshd 2>/dev/null || sudo systemctl status ssh 2>/dev/null || echo "SSH service not running"
  
  echo "=== Listening Ports ==="
  # Usar ss en lugar de netstat (más moderno y disponible por defecto)
  sudo ss -tlnp | grep :22 2>/dev/null || echo "Port 22 not listening (using ss)"
  
  # Alternativa con lsof si ss no funciona
  sudo lsof -i :22 2>/dev/null || echo "Port 22 not listening (using lsof)"
  
  # Mostrar todos los puertos SSH posibles
  sudo ss -tlnp | grep ssh 2>/dev/null || echo "No SSH ports found"
  
  echo "=== SSH Processes ==="
  ps aux | grep ssh | grep -v grep || echo "No SSH processes found"
  
  echo "=== Network Tools Available ==="
  which ss && echo "ss: available" || echo "ss: not found"
  which netstat && echo "netstat: available" || echo "netstat: not found"
  which lsof && echo "lsof: available" || echo "lsof: not found"
  
  # Intentar ir al directorio de trabajo
  cd /home/ubuntu/server/jenkis2 || {
    echo "Directory not found, creating it..."
    mkdir -p /home/ubuntu/server/jenkis2
    cd /home/ubuntu/server/jenkis2
  }

  # Ejecutar git pull si el directorio existe y es un repo
  if [ -d .git ]; then
    git pull origin main
  else
    echo "Not a git repository. Please clone the repository first."
  fi
EOF