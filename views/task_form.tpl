%rebase('layout', title='Nova Tarefa' if task is None else 'Editar Tarefa')

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
.form-group textarea,
.form-group select {
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
            {{'Nova Tarefa' if task is None else 'Editar Tarefa'}}
        </h1>
    </div>

    <form action="{{action}}" method="post" class="task-form">
        <div class="form-group">
            <label for="title">Título da Tarefa:</label>
            <input type="text" id="title" name="title" value="{{task.title if task else ''}}" required>
        </div>

        <div class="form-group">
            <label for="description">Descrição:</label>
            <textarea id="description" name="description">{{task.description if task else ''}}</textarea>
        </div>

        <div class="form-group">
            <label for="projeto_id">Projeto (Opcional):</label>
            <select id="projeto_id" name="projeto_id">
                <option value="None">📝 Sem Projeto</option>
                % for projeto in projetos:
                <option value="{{projeto.id}}" {{'selected' if task and task.projeto_id == projeto.id else ''}}>
                    {{projeto.nome}}
                </option>
                % end
            </select>
            <small style="color: #666;">Agrupe tarefas em projetos para melhor organização</small>
        </div>

        <div class="form-actions">
                <button type="submit" class="btn btn-primary">
            {{'Criar Tarefa' if task is None else 'Atualizar Tarefa'}}
        </button>
        <a href="/tasks" class="btn btn-secondary">← Voltar para Tarefas</a>
        <a href="/" class="btn btn-secondary">Home</a>
    </div>
</section>