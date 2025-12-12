import 'dart:io';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:unihub/config/api_config.dart';

class GeminiService {
  static GeminiService? _instance;
  GenerativeModel? _model;
  ChatSession? _chat;
  bool _isInitialized = false;

  GeminiService._();

  static GeminiService getInstance() {
    _instance ??= GeminiService._();
    return _instance!;
  }

  void _initialize() {
    if (_isInitialized) return;
    
    if (!ApiConfig.isGeminiConfigured) {
      throw Exception('Please set your GEMINI_API_KEY in lib/config/api_config.dart');
    }

    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: ApiConfig.geminiApiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        maxOutputTokens: 2048,
      ),
      systemInstruction: Content.text(
        '''You are UniHub AI, a helpful academic assistant for college students. 
        You help with:
        - Study planning and scheduling
        - Answering academic doubts
        - Exam preparation tips
        - Note organization
        - Time management
        Keep responses concise, friendly, and actionable.''',
      ),
    );
    _chat = _model!.startChat();
    _isInitialized = true;
  }

  // Check if service is ready
  bool get isReady => ApiConfig.isGeminiConfigured;

  // General chat with UniHub AI
  Future<String> chat(String message) async {
    try {
      _initialize();
      final response = await _chat!.sendMessage(Content.text(message));
      return response.text ?? 'I couldn\'t process that. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error: $e';
    }
  }

  // Generate study plan with JSON output
  Future<String> generateStudyPlan({
    required String subject,
    required String availableTime,
    required String focusType,
    String? additionalContext,
  }) async {
    final prompt = '''
You are an AI Study Planner. Create a personalized study plan based on the following inputs:

**Subject/Topic:** $subject
**Available Time:** $availableTime
**Focus Type:** $focusType
${additionalContext != null ? '**Additional Context:** $additionalContext' : ''}

IMPORTANT: Respond ONLY with a valid JSON object (no markdown, no explanation, just pure JSON).

Use this exact JSON structure:
{
  "recommendation": "A personalized AI recommendation message about what to focus on today based on the subject and time available (1-2 sentences)",
  "motivational_tip": "A short motivational quote or tip to keep the student motivated",
  "streak_days": 7,
  "weekly_tasks": [
    {
      "title": "Main subject or topic name",
      "subtitle": "Brief description of focus area",
      "hours_left": 4,
      "chapters": "Chapter numbers or section names",
      "priority": "high",
      "topics": [
        {"name": "Specific topic 1 to study", "description": "Brief description of what to cover"},
        {"name": "Specific topic 2 to study", "description": "Brief description of what to cover"},
        {"name": "Specific topic 3 to study", "description": "Brief description of what to cover"}
      ]
    },
    {
      "title": "Second task (like Review or Practice)",
      "subtitle": "Description of what to do",
      "hours_left": 2,
      "chapters": "Related topics",
      "priority": "medium",
      "topics": [
        {"name": "Topic to review", "description": "What to focus on"},
        {"name": "Practice area", "description": "Types of problems to solve"}
      ]
    }
  ],
  "key_topics": ["Topic 1", "Topic 2", "Topic 3", "Topic 4"],
  "study_techniques": ["Technique 1 suited for the focus type", "Technique 2", "Technique 3"],
  "break_recommendation": "Specific break schedule recommendation"
}

Rules:
- Create 2-4 weekly_tasks based on the subject and available time
- Each weekly_task MUST have 2-5 specific topics with name and description
- priority must be one of: "high", "medium", "low"
- hours_left should be realistic based on available time
- Make the recommendation personalized and specific to the subject
- study_techniques should match the focus type ($focusType)
- Topics should be specific, actionable items the student can check off
- Return ONLY the JSON, no other text
''';

    try {
      _initialize();
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to generate study plan. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error generating study plan: $e';
    }
  }

  // Solve academic doubts
  Future<String> solveDoubt(String question, {String? subject}) async {
    final prompt = '''
${subject != null ? 'Subject: $subject\n' : ''}
Student Question: $question

Please provide:
1. A clear, step-by-step explanation
2. Examples if applicable
3. Key concepts to remember
4. Related topics to explore
''';

    try {
      _initialize();
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to answer. Please try again.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Analyze document/notes for exam prep
  Future<String> analyzeForExam(String content) async {
    final prompt = '''
Analyze the following study material and provide exam preparation insights:

$content

Please provide:
1. Key concepts likely to be tested
2. Important definitions and formulas
3. Potential exam questions
4. Topics that need more focus
5. Quick revision points
''';

    try {
      _initialize();
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to analyze. Please try again.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Reset chat session
  void resetChat() {
    if (_model != null) {
      _chat = _model!.startChat();
    }
  }

  // Get MIME type for file extension
  String getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'txt':
        return 'text/plain';
      case 'md':
        return 'text/markdown';
      case 'csv':
        return 'text/csv';
      case 'json':
        return 'application/json';
      case 'xml':
        return 'application/xml';
      case 'html':
        return 'text/html';
      case 'js':
        return 'text/javascript';
      case 'py':
      case 'dart':
      case 'java':
      case 'c':
      case 'cpp':
      case 'h':
        return 'text/plain';
      default:
        return 'text/plain';
    }
  }

  // Extract text from PDF file (fallback method)
  Future<String> extractTextFromPdf(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      
      String extractedText = '';
      final PdfTextExtractor extractor = PdfTextExtractor(document);
      for (int i = 0; i < document.pages.count; i++) {
        extractedText += extractor.extractText(startPageIndex: i, endPageIndex: i);
        extractedText += '\n\n--- Page ${i + 1} ---\n\n';
      }
      
      document.dispose();
      return extractedText.trim();
    } catch (e) {
      throw Exception('Failed to extract text from PDF: $e');
    }
  }

  // Read file and return content info for processing
  Future<DocumentContent> readDocument(String filePath) async {
    try {
      final file = File(filePath);
      final extension = filePath.toLowerCase().split('.').last;
      final bytes = await file.readAsBytes();
      final mimeType = getMimeType(extension);
      
      // For PDF files, we'll send bytes directly for vision processing
      if (extension == 'pdf') {
        return DocumentContent(
          bytes: bytes,
          mimeType: mimeType,
          isPdf: true,
          textContent: null,
        );
      }
      
      // For text-based files, read as string
      if (['txt', 'md', 'csv', 'json', 'xml', 'html', 'dart', 'py', 'js', 'java', 'c', 'cpp', 'h'].contains(extension)) {
        final text = await file.readAsString();
        return DocumentContent(
          bytes: null,
          mimeType: mimeType,
          isPdf: false,
          textContent: text,
        );
      }
      
      throw Exception('Unsupported file type: $extension');
    } catch (e) {
      throw Exception('Failed to read file: $e');
    }
  }

  // Legacy method for backward compatibility
  Future<String> extractTextFromFile(String filePath) async {
    try {
      final file = File(filePath);
      final extension = filePath.toLowerCase().split('.').last;
      
      if (extension == 'pdf') {
        return extractTextFromPdf(filePath);
      } else if (['txt', 'md', 'csv', 'json', 'xml', 'html', 'dart', 'py', 'js', 'java', 'c', 'cpp', 'h'].contains(extension)) {
        return await file.readAsString();
      } else {
        throw Exception('Unsupported file type: $extension');
      }
    } catch (e) {
      throw Exception('Failed to read file: $e');
    }
  }

  // Chat with document - supports PDF, images, and text files
  Future<String> chatWithDocument({
    required String documentContent,
    required String fileName,
    String? userMessage,
    Uint8List? fileBytes, // Optional: pass raw file bytes for native vision processing
    String? mimeType, // MIME type for the file (e.g., 'application/pdf', 'image/png')
  }) async {
    try {
      _initialize();
      
      final userPrompt = userMessage ?? 
          'Please analyze this document and provide a summary of its key points, important concepts, and any notable information that would be helpful for studying.';
      
      // If file bytes are provided, use native vision processing (for PDFs and images)
      if (fileBytes != null) {
        // Determine MIME type from file extension if not provided
        final extension = fileName.split('.').last.toLowerCase();
        final actualMimeType = mimeType ?? getMimeType(extension);
        
        final content = Content.multi([
          TextPart('I\'ve uploaded a file named "$fileName".\n\n$userPrompt'),
          DataPart(actualMimeType, fileBytes),
        ]);
        
        final response = await _chat!.sendMessage(content);
        return response.text ?? 'I couldn\'t process the file. Please try again.';
      }
      
      // Otherwise, use text-based processing
      final prompt = '''
I've uploaded a document named "$fileName". Here's its content:

---START OF DOCUMENT---
$documentContent
---END OF DOCUMENT---

$userPrompt
''';

      final response = await _chat!.sendMessage(Content.text(prompt));
      return response.text ?? 'I couldn\'t process the document. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error analyzing document: $e';
    }
  }

  // Analyze uploaded document for study - with native PDF/image support
  Future<String> analyzeDocument({
    required String documentContent,
    required String fileName,
    required String analysisType,
    Uint8List? fileBytes,
    String? mimeType,
  }) async {
    String promptText;
    
    switch (analysisType) {
      case 'summary':
        promptText = '''
Analyze this document "$fileName" and provide:
1. A comprehensive summary
2. Main topics covered
3. Key takeaways
''';
        break;
      case 'exam_prep':
        promptText = '''
Analyze this document "$fileName" for exam preparation:
1. Key concepts likely to be tested
2. Important definitions and formulas
3. 5-10 potential exam questions with brief answers
4. Topics that need more focus
5. Quick revision bullet points
''';
        break;
      case 'notes':
        promptText = '''
Convert this document "$fileName" into well-organized study notes:
1. Create clear headings and subheadings
2. Highlight key terms and definitions
3. Summarize complex concepts simply
4. Add bullet points for easy revision
5. Include any formulas or important data
''';
        break;
      case 'questions':
        promptText = '''
Based on this document "$fileName", generate practice questions:
1. 5 Multiple Choice Questions (with correct answers)
2. 5 Short Answer Questions
3. 2-3 Essay/Long Answer Questions
4. Key concepts each question tests
''';
        break;
      default:
        promptText = 'Analyze this document "$fileName" and help me understand it better.';
    }

    try {
      _initialize();
      
      // If file bytes are provided, use native vision processing
      if (fileBytes != null) {
        final extension = fileName.split('.').last.toLowerCase();
        final actualMimeType = mimeType ?? getMimeType(extension);
        
        final content = Content.multi([
          TextPart(promptText),
          DataPart(actualMimeType, fileBytes),
        ]);
        
        final response = await _model!.generateContent([content]);
        return response.text ?? 'Unable to analyze document. Please try again.';
      }
      
      // Otherwise, use text-based processing
      final prompt = '''
$promptText

Document content:
$documentContent
''';

      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to analyze document. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error: $e';
    }
  }

  // Transcribe handwritten notes from image - Step 1
  Future<String> transcribeHandwriting(Uint8List imageBytes, String mimeType) async {
    try {
      _initialize();
      
      const prompt = '''
Transcribe this handwritten page as accurately as possible.
Preserve line breaks and bullets.
If a word is unclear, output [UNK] (don't guess).
Return only plain text.
''';

      final content = Content.multi([
        TextPart(prompt),
        DataPart(mimeType, imageBytes),
      ]);
      
      final response = await _model!.generateContent([content]);
      return response.text ?? 'Unable to transcribe. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error transcribing: $e';
    }
  }

  // Convert transcription to structured notes JSON - Step 2
  Future<String> convertToStructuredNotes(String transcription) async {
    try {
      _initialize();
      
      final prompt = '''
Convert the following transcription into structured study notes.

TRANSCRIPTION:
$transcription

IMPORTANT: Respond ONLY with a valid JSON object (no markdown, no explanation, just pure JSON).

Use this exact JSON structure:
{
  "title": "A descriptive title for these notes based on the content",
  "key_points": [
    "Key point 1",
    "Key point 2",
    "Key point 3"
  ],
  "definitions": [
    {"term": "Term 1", "definition": "Definition of term 1"},
    {"term": "Term 2", "definition": "Definition of term 2"}
  ],
  "formulas": [
    {"name": "Formula name", "formula": "The formula itself", "description": "What it's used for"}
  ],
  "examples": [
    {"title": "Example title", "content": "Example explanation or problem solved"}
  ],
  "flashcards": [
    {"front": "Question or term", "back": "Answer or definition"},
    {"front": "Question or term", "back": "Answer or definition"},
    {"front": "Question or term", "back": "Answer or definition"},
    {"front": "Question or term", "back": "Answer or definition"},
    {"front": "Question or term", "back": "Answer or definition"}
  ],
  "quiz_questions": [
    {"question": "Quiz question 1?", "answer": "Correct answer", "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]},
    {"question": "Quiz question 2?", "answer": "Correct answer", "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]},
    {"question": "Quiz question 3?", "answer": "Correct answer", "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]},
    {"question": "Quiz question 4?", "answer": "Correct answer", "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]},
    {"question": "Quiz question 5?", "answer": "Correct answer", "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]}
  ],
  "summary": "A brief 2-3 sentence summary of the notes"
}

Rules:
- Generate at least 3 key_points from the content
- Extract all definitions found, or create 2-3 if none explicit
- Include formulas only if present in the notes, otherwise empty array
- Create examples from worked problems or create 1-2 based on content
- Generate exactly 5 flashcards for key concepts
- Generate exactly 5 quiz questions with 4 options each
- Make the title specific to the actual content
- Return ONLY the JSON, no other text
''';

      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to convert notes. Please try again.';
    } catch (e) {
      if (e.toString().contains('API_KEY')) {
        return 'Please configure your Gemini API key in lib/config/api_config.dart';
      }
      return 'Error converting notes: $e';
    }
  }
}

// Helper class to hold document content
class DocumentContent {
  final Uint8List? bytes;
  final String mimeType;
  final bool isPdf;
  final String? textContent;

  DocumentContent({
    required this.bytes,
    required this.mimeType,
    required this.isPdf,
    required this.textContent,
  });
}

// Model class for structured notes
class StructuredNotes {
  final String title;
  final List<String> keyPoints;
  final List<Map<String, String>> definitions;
  final List<Map<String, String>> formulas;
  final List<Map<String, String>> examples;
  final List<Map<String, String>> flashcards;
  final List<Map<String, dynamic>> quizQuestions;
  final String summary;

  StructuredNotes({
    required this.title,
    required this.keyPoints,
    required this.definitions,
    required this.formulas,
    required this.examples,
    required this.flashcards,
    required this.quizQuestions,
    required this.summary,
  });

  factory StructuredNotes.fromJson(Map<String, dynamic> json) {
    return StructuredNotes(
      title: json['title'] ?? 'Untitled Notes',
      keyPoints: List<String>.from(json['key_points'] ?? []),
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList() ?? [],
      formulas: (json['formulas'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList() ?? [],
      examples: (json['examples'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList() ?? [],
      flashcards: (json['flashcards'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList() ?? [],
      quizQuestions: (json['quiz_questions'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e as Map))
          .toList() ?? [],
      summary: json['summary'] ?? '',
    );
  }
}
