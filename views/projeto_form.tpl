%rebase('layout', title='Novo Projeto' if projeto is None else 'Editar Projeto')

<style>
.form-section {
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee;
}

.section-title {
    margin: 0;
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

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

.form-group textarea {
    resize: vertical;
    min-height: 100px;
}

.form-actions {
    display: flex;
    gap: 10px;
    margin-top: 30px;
}

.btn {
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    text-decoration: none;
    text-align: center;
    display: inline-block;
}

.btn-primary {
    background: #007bff;
    color: white;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}
</style>

<section class="form-section">
    <div class="section-header">
        <h1 class="section-title">
            {{'Novo Projeto' if projeto is None else 'Editar Projeto'}}
        </h1>
    </div>

    <form action="{{action}}" method="post" class="task-form">
        <div class="form-group">
            <label for="nome">Nome do Projeto:</label>
            <input type="text" id="nome" name="nome" 
                   value="{{projeto.nome if projeto else ''}}" 
                   placeholder="Digite o nome do projeto" required>
        </div>

        <div class="form-group">
            <label for="descricao">Descrição:</label>
            <textarea id="descricao" name="descricao" rows="4" 
                      placeholder="Descreva o projeto...">{{projeto.descricao if projeto else ''}}</textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                {{'Criar Projeto' if projeto is None else 'Atualizar Projeto'}}
            </button>
            <a href="/projetos" class="btn btn-secondary">← Voltar para Projetos</a>
            <a href="/" class="btn btn-secondary">Home</a>
        </div>
    </form>
</section>