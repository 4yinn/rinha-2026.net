
var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/ready", () => "hello world");
// app.MapPost("/fraud-score", async (Payload payload) => { return Results.Ok(); }
// );

app.Run();