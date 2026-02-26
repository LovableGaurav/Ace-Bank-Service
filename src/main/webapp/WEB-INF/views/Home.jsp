<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AceBank Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --success: #10b981;
            --danger: #ef4444;
            --background: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--text-main);
            line-height: 1.6;
        }

        /* Header Navigation */
        header {
            background: white;
            padding: 1rem 5%;
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo { font-size: 1.5rem; font-weight: 700; color: #000; }
        .logo span { color: var(--primary); }

        nav ul { list-style: none; display: flex; gap: 2rem; align-items: center; }
        nav a { text-decoration: none; color: var(--text-muted); font-weight: 500; transition: 0.3s; }
        nav a:hover { color: var(--primary); }

        .logout-btn {
            background: #fff1f2;
            color: var(--danger);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Dashboard Layout */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 20px;
        }

        .welcome-header { margin-bottom: 2rem; }
        .welcome-header h1 { font-size: 1.8rem; margin-bottom: 5px; }
        .acc-badge {
            background: var(--primary);
            color: white;
            padding: 2px 10px;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        /* Action Cards Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .card {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            border: 1px solid var(--border);
        }

        .balance-card {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            color: white;
            border: none;
        }

        .balance-card h3 { opacity: 0.8; font-weight: 400; }
        .balance-card h1 { font-size: 2.2rem; margin: 10px 0; }

        /* Form Styling */
        .card h3 { margin-bottom: 1rem; font-size: 1.1rem; }
        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 12px;
            border: 1px solid var(--border);
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }
        input:focus { border-color: var(--primary); }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: var(--primary);
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover { background: var(--primary-hover); transform: translateY(-1px); }

        /* Transactions Table */
        .transactions-section {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 12px; color: var(--text-muted); border-bottom: 2px solid var(--background); }
        td { padding: 15px 12px; border-bottom: 1px solid var(--background); }

        /* Transaction Type Badges */
        .badge-deposit { color: var(--success); font-weight: 600; }
        .badge-withdraw { color: var(--danger); font-weight: 600; }
        .badge-transfer { color: var(--primary); font-weight: 600; }
    </style>
</head>
<body>

<header>
    <div class="nav-container">
        <h1 class="logo">Ace<span>Bank</span></h1>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Profile &amp; Settings</a></li>
                <li><a href="ChangePassword.jsp">Reset Password</a></li>
                <li><a href="Logout" class="logout-btn"><i class="ri-logout-box-r-line"></i> Logout</a></li>
            </ul>
        </nav>
    </div>
</header>

<main class="container">
    <div class="welcome-header">
        <h1>Hello, ${sessionScope.firstName} 👋</h1>
        <p>Account Number: <span class="acc-badge">${sessionScope.accountNumber}</span></p>
    </div>

    <div class="dashboard-grid">
        <article class="card balance-card">
            <h3>Total Balance</h3>
            <h1>₹ <span id="balance-counter">${sessionScope.balance}</span></h1>
            <p style="font-size: 0.8rem; opacity: 0.7;">Available for instant withdrawal</p>
        </article>

        <article class="card">
            <h3>Quick Deposit</h3>
            <form action="home" method="post">
                <input type="text" name="deposit" placeholder="Amount (₹)" pattern="[0-9]*\.?[0-9]+" required/>
                <button type="submit">Add to Balance</button>
            </form>
        </article>

        <article class="card">
            <h3>Send Money</h3>
            <form action="home" method="post">
                <input type="text" name="toAccount" placeholder="Recipient Account No" required/>
                <input type="text" name="toAmount" placeholder="Amount (₹)" pattern="[0-9]*\.?[0-9]+" required/>
                <button type="submit">Transfer Now</button>
            </form>
        </article>

        <article class="card">
            <h3>Withdraw</h3>
            <form action="home" method="post">
                <input type="text" name="withdraw" placeholder="Amount (₹)" pattern="[0-9]*\.?[0-9]+" required/>
                <button type="submit" style="background: #64748b;">Withdraw Now</button>
            </form>
        </article>
    </div>

    <section class="transactions-section">
        <div class="table-header">
            <h3>Recent Transactions</h3>
            <button style="width: auto; padding: 8px 16px; font-size: 0.8rem;">Download CSV</button>
        </div>
        <table>
            <thead>
            <tr>
                <th>Date</th>
                <th>Type</th>
                <th>Reference</th>
                <th>Amount</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
                <tr>
                    <td>${tx.createdAt()}</td>
                    <td><span class="badge-${tx.txType().toLowerCase()}">${tx.txType()}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${tx.txType() == 'TRANSFER'}">
                                ${tx.senderAccount() == sessionScope.accountNumber ? 'To' : 'From'}
                                <strong>${tx.senderAccount() == sessionScope.accountNumber ? tx.receiverAccount() : tx.senderAccount()}</strong>
                            </c:when>
                            <c:otherwise>${tx.remark()}</c:otherwise>
                        </c:choose>
                    </td>
                    <td><strong>₹${tx.amount()}</strong></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Balance Counter Animation
        const balanceElement = document.getElementById('balance-counter');
        if (balanceElement) {
            const rawValue = balanceElement.innerText.replace(/,/g, '');
            const target = parseFloat(rawValue) || 0;
            const duration = 1000; // 1 second animation
            const startTime = performance.now();

            const updateCount = (currentTime) => {
                const elapsed = currentTime - startTime;
                const progress = Math.min(elapsed / duration, 1);

                // Ease out cubic function for smooth finish
                const easeOut = 1 - Math.pow(1 - progress, 3);
                const currentBalance = easeOut * target;

                balanceElement.innerText = currentBalance.toLocaleString('en-IN', {
                    maximumFractionDigits: 2
                });

                if (progress < 1) {
                    requestAnimationFrame(updateCount);
                }
            };
            requestAnimationFrame(updateCount);
        }
    });
</script>

<c:if test="${param.loanSuccess eq 'true'}">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            alert('Your loan details have been emailed to you. Our executive will contact you shortly.');
        });
    </script>
</c:if>

</body>
</html>