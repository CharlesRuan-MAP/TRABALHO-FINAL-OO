%rebase('layout', title='Criar Conta')

<style>
.register-container {
    max-width: 500px;
    margin: 50px auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.register-container h1 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

.form-group input:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 5px rgba(0,123,255,0.3);
}

.btn-register {
    width: 100%;
    padding: 12px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 10px;
}

.btn-register:hover {
    background: #218838;
}

.login-link {
    text-align: center;
    margin-top: 20px;
}

.login-link a {
    color: #007bff;
    text-decoration: none;
}

.login-link a:hover {
    text-decoration: underline;
}

.alert-error {
    background: #f8d7da;
    color: #721c24;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
    text-align: center;
}

.password-requirements {
    font-size: 0.8em;
    color: #666;
    margin-top: 5px;
}
</style>

<div class="register-container">
    <h1>👥 Criar Nova Conta</h1>
    
    % if defined('erro'):
    <div class="alert-error">
        {{erro}}
    </div>
    % end

    <form method="post">
        <div class="form-group">
            <label for="nome">Nome Completo:</label>
            <input type="text" id="nome" name="nome" value="{{nome if defined('nome') else ''}}" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="{{email if defined('email') else ''}}" required>
        </div>

        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <div class="password-requirements">Mínimo 6 caracteres</div>
        </div>

        <div class="form-group">
            <label for="confirmar_senha">Confirmar Senha:</label>
            <input type="password" id="confirmar_senha" name="confirmar_senha" required>
        </div>

        <div class="form-group">
            <label for="birthdate">Data de Nascimento:</label>
            <input type="date" id="birthdate" name="birthdate" required>
        </div>

        <button type="submit" class="btn-register">Criar Conta</button>
    </form>

    <div class="login-link">
        <p>Já tem uma conta? <a href="/login">Faça login aqui</a></p>
    </div>
</div>