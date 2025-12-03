%rebase('layout', title='Login')

<div style="max-width: 400px; margin: 100px auto; padding: 20px;">
    <h1>Login</h1>
    
    % if defined('erro'):
    <div style="background: #ffebee; color: #c62828; padding: 10px; border-radius: 5px; margin: 10px 0;">
        {{erro}}
    </div>
    % end

    <form method="post" style="margin: 20px 0;">
        <div style="margin-bottom: 15px;">
            <label>Email:</label>
            <input type="email" name="email" required style="width: 100%; padding: 8px; margin-top: 5px;" value="teste@email.com">
        </div>
        
        <div style="margin-bottom: 15px;">
            <label>Senha:</label>
            <input type="password" name="senha" required style="width: 100%; padding: 8px; margin-top: 5px;" value="123456">
        </div>
        
        <button type="submit" style="width: 100%; padding: 10px; background: #007bff; color: white; border: none; border-radius: 5px;">
            Entrar
        </button>
    </form>

    <div style="background: #e3f2fd; padding: 15px; border-radius: 5px; margin-top: 20px;">
        <p><strong>Usuário de teste:</strong></p>
        <p>Email: <code>teste@email.com</code></p>
        <p>Senha: <code>123456</code></p>
    </div>
</div>