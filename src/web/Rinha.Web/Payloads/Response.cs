namespace Rinha.Web.Payloads;

public sealed record Response
{
    public bool Approved { get; private set; } = false;
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