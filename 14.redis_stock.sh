# !/bin/bash
# 200번 반복하면서 재고 확인 및 감소
for i in {1..200}; do
    quantity=$(redis-cli -h localhost -p 6379 get apple:1:quantuty)
    if [ "$quantity" -lt 1 ]; then
        echo "재고가 부족합니다. 현재 재고 : $quantity"
        break;
    fi
    redis-cli -h localhost -p 6379 decr apple:1:quantuty
    echo "현재 재고 : $quantity"
done