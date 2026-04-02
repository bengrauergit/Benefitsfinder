// Vercel Serverless Function: /api/chat
// Proxies chat messages to the Anthropic Claude API
// Requires ANTHROPIC_API_KEY environment variable set in Vercel project settings

export default async function handler(req, res) {
  // Only allow POST
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  // Check for API key
  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return res.status(500).json({
      error: 'ANTHROPIC_API_KEY is not configured. Add it to your Vercel project environment variables.'
    });
  }

  try {
    const { messages, systemContext } = req.body;

    if (!messages || !Array.isArray(messages) || messages.length === 0) {
      return res.status(400).json({ error: 'Messages array is required' });
    }

    // Build the system prompt
    const systemPrompt = systemContext || `You are a friendly, knowledgeable Australian benefits advisor. Help users find and claim government benefits, grants, rebates, and concessions. Be specific, practical, and encouraging.`;

    // Format messages for the Anthropic API
    const formattedMessages = messages.map(msg => ({
      role: msg.role,
      content: msg.content
    }));

    // Call the Anthropic API
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-20250514',
        max_tokens: 1024,
        system: systemPrompt,
        messages: formattedMessages
      })
    });

    if (!response.ok) {
      const errorBody = await response.text();
      console.error('Anthropic API error:', response.status, errorBody);

      if (response.status === 401) {
        return res.status(401).json({ error: 'Invalid API key. Check your ANTHROPIC_API_KEY in Vercel environment variables.' });
      }
      if (response.status === 429) {
        return res.status(429).json({ error: 'Rate limited. Please wait a moment and try again.' });
      }

      return res.status(502).json({ error: 'Failed to get response from AI service. Please try again.' });
    }

    const data = await response.json();

    // Extract the text response
    const assistantMessage = data.content
      .filter(block => block.type === 'text')
      .map(block => block.text)
      .join('\n');

    return res.status(200).json({ response: assistantMessage });

  } catch (error) {
    console.error('Chat API error:', error);
    return res.status(500).json({ error: 'Internal server error. Please try again.' });
  }
}
