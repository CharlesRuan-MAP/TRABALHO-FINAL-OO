%rebase('layout', title='Bem-vindo - Sistema de Tarefas')

<style>
.welcome-hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 80px 20px;
    text-align: center;
    border-radius: 10px;
    margin-bottom: 40px;
}

.hero-content h1 {
    font-size: 2.5em;
    margin-bottom: 10px;
}

.hero-subtitle {
    font-size: 1.2em;
    opacity: 0.9;
    margin-bottom: 40px;
    line-height: 1.5;
}

.hero-stats {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin: 40px 0;
    flex-wrap: wrap;
}

.stat {
    text-align: center;
    min-width: 120px;
}

.stat-number {
    display: block;
    font-size: 2.2em;
    font-weight: bold;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 0.9em;
    opacity: 0.8;
}

.hero-actions {
    margin-top: 30px;
    display: flex;
    gap: 15px;
    justify-content: center;
    flex-wrap: wrap;
}

.btn-large {
    padding: 12px 25px;
    font-size: 1.1em;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    display: inline-block;
}

.btn-primary {
    background: #007bff;
    color: white;
    border: none;
}

.btn-secondary {
    background: #6c757d;
    color: white;
    border: none;
}

.btn-primary:hover, .btn-secondary:hover {
    opacity: 0.9;
    transform: translateY(-2px);
    transition: all 0.3s ease;
    text-decoration: none;
}

.features-section {
    padding: 60px 20px;
    text-align: center;
}

.features-section h2 {
    margin-bottom: 40px;
    color: #333;
    font-size: 2em;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 30px;
    max-width: 1000px;
    margin: 0 auto;
}

.feature-card {
    padding: 30px 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    text-align: center;
    transition: transform 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-5px);
}

.feature-icon {
    font-size: 3em;
    margin-bottom: 15px;
}

.feature-card h3 {
    margin-bottom: 15px;
    color: #333;
    font-size: 1.3em;
}

.feature-card p {
    color: #666;
    line-height: 1.5;
}

.demo-login {
    background: #e7f3ff;
    padding: 25px;
    border-radius: 10px;
    margin-top: 40px;
    text-align: center;
}

.demo-login code {
    background: #f8f9fa;
    padding: 8px 15px;
    border-radius: 5px;
    font-family: monospace;
    margin: 0 5px;
}

@media (max-width: 768px) {
    .hero-content h1 {
        font-size: 2em;
    }
    
    .hero-stats {
        gap: 20px;
    }
    
    .stat-number {
        font-size: 1.8em;
    }
    
    .hero-actions {
        flex-direction: column;
        align-items: center;
    }
    
    .btn-large {
        width: 200px;
        text-align: center;
    }
}
</style>

<div class="welcome-hero">
    <div class="hero-content">
        <h1> Sistema de Gestão de Tarefas</h1>
        <p class="hero-subtitle">Organize suas tarefas, projetos e equipe em um só lugar</p>
        
        <div class="hero-stats">
            <div class="stat">
                <span class="stat-number">{{total_tasks or 0}}</span>
                <span class="stat-label">Tarefas Criadas</span>
            </div>
            <div class="stat">
                <span class="stat-number">{{total_users or 0}}</span>
                <span class="stat-label">Usuários Ativos</span>
            </div>
            <div class="stat">
                <span class="stat-number">{{total_projetos or 0}}</span>
                <span class="stat-label">Projetos</span>
            </div>
        </div>

        <div class="hero-actions">
            <a href="/login" class="btn-large btn-primary"> Fazer Login</a>
            <a href="/register" class="btn-large btn-secondary"> Criar Conta</a>
        </div>
    </div>
</div>

<div class="features-section">
    <h2> Por que usar nosso sistema?</h2>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Tarefas Inteligentes</h3>
            <p>Crie, organize e acompanhe suas tarefas com status de conclusão e descrições detalhadas</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Gestão de Equipe</h3>
            <p>Diferentes níveis de usuário: comuns e administradores com permissões específicas</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Projetos Organizados</h3>
            <p>Agrupe tarefas em projetos para melhor organização e acompanhamento do progresso</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Segurança</h3>
            <p>Sistema de login seguro com senhas criptografadas e controle de acesso</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Dashboard Interativo</h3>
            <p>Visualize suas estatísticas e progresso de forma clara e intuitiva</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Rápido e Simples</h3>
            <p>Interface limpa e fácil de usar, focada na produtividade e eficiência</p>
        </div>
    </div>
</div>

<div class="demo-login">
    <h3 style="margin-bottom: 15px;"> Teste o sistema agora mesmo!</h3>
    <p style="margin-bottom: 15px; color: #666;">Use nossa conta de demonstração para explorar todas as funcionalidades</p>
    <div>
        <strong>Email:</strong> <code>teste@email.com</code> | 
        <strong>Senha:</strong> <code>123456</code>
    </div>
</div>