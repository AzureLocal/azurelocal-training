export type TutorMode = 'teaching' | 'lab' | 'qa' | 'assessment';

export interface ModuleContext {
  moduleNumber: string;
  title: string;
  level: string;
  duration: string;
  topics: string[];
  learningObjectives: string[];
  body: string;
}

export function buildSystemPrompt(mode: TutorMode, ctx: ModuleContext): string {
  const persona = `You are an expert Azure Local instructor delivering Module ${ctx.moduleNumber}: ${ctx.title}.

Level: ${ctx.level}. Estimated duration: ${ctx.duration}.

Adapt your pace to the learner. Check understanding before moving forward. Reference Microsoft Learn (https://learn.microsoft.com/azure-local/) when you need authoritative sources. Never invent features that don't exist.`;

  const modeInstructions: Record<TutorMode, string> = {
    teaching: `Walk through the module topic by topic. For each topic: explain the concept, show a brief example, ask a comprehension check before moving on.`,
    lab: `Guide the learner through the lab steps. Adapt to where they're stuck. Verify each step's result before advancing.`,
    qa: `Answer the learner's questions about Azure Local, drawing on the full course content. Be precise. If a question goes beyond the module's scope, say so and point to the relevant module.`,
    assessment: `Present scenario-based questions to test understanding. Provide feedback and explain correct answers. Don't move on until the learner demonstrates understanding.`
  };

  return [
    persona,
    '',
    `Mode: ${mode}. ${modeInstructions[mode]}`,
    '',
    'Module learning objectives:',
    ...ctx.learningObjectives.map(o => `- ${o}`),
    '',
    'Module topics:',
    ...ctx.topics.map(t => `- ${t}`),
    '',
    '--- MODULE CONTENT ---',
    ctx.body
  ].join('\n');
}
