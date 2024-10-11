WITH balances AS (
    SELECT
        account,
        SUM(amount) AS balance
    FROM transactions
    GROUP BY account
)

SELECT
    name,
    balance
FROM users
LEFT JOIN balances
    ON users.account = balances.account
WHERE balance > 10000;