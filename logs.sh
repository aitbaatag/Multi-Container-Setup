#!/bin/bash
# Check MariaDB logs
echo "=== MariaDB Logs ==="
docker logs mariadb | tail -n 50

echo ""
echo "=== WordPress Logs ==="
docker logs wordpress | tail -n 50

echo ""
echo "=== Nginx Logs ==="
docker logs nginx | tail -n 50

echo ""
echo "=== redis Logs ==="
docker logs redis | tail -n 50

echo ""
echo "=== ftp Logs ==="
docker logs ftp | tail -n 50
