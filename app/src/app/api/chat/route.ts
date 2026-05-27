import { NextRequest, NextResponse } from 'next/server';
import { anthropic, DEFAULT_MODEL } from '@/lib/anthropic';

export const runtime = 'nodejs';

interface ChatRequest {
  systemPrompt: string;
  messages: Array<{ role: 'user' | 'assistant'; content: string }>;
  model?: string;
}

export async function POST(req: NextRequest) {
  const body = (await req.json()) as ChatRequest;

  if (!body.systemPrompt || !body.messages?.length) {
    return NextResponse.json({ error: 'Missing systemPrompt or messages' }, { status: 400 });
  }

  const response = await anthropic.messages.create({
    model: body.model ?? DEFAULT_MODEL,
    max_tokens: 2048,
    system: body.systemPrompt,
    messages: body.messages
  });

  const text = response.content
    .filter(block => block.type === 'text')
    .map(block => (block.type === 'text' ? block.text : ''))
    .join('\n');

  return NextResponse.json({ text, usage: response.usage });
}
