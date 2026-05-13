namespace Rinha.Web.Models.Response;

public sealed record FraudScoreResponse
{
    public bool Approved { get; private set; }
    public float FraudScore { get; private set; }


    public void ChangeApproved(float score)
    {
        if (score >= 0.6)
        {
            Approved = false;
            FraudScore = score;
            return;
        }

        Approved = true;
        FraudScore = score;
    }
}